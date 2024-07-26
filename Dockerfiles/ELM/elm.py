#script provided by Jack Tierney - https://github.com/JackCurragh

import requests
from Bio import SeqIO
import pandas as pd
import time
import sys


def query_elm(sequence, record_id, max_retries=5, delay=30):
    url = f"http://elm.eu.org/start_search/{sequence}"
    for attempt in range(max_retries):
        try:
            response = requests.get(url)
            response.raise_for_status()  # Ensure we notice bad responses
            tsv_data = response.content.decode('utf-8')
            break  # If we reach here, no exception was raised
        except requests.exceptions.HTTPError as e:
            if response.status_code == 429:
                print(f"Rate limited. Retrying in {delay} seconds...")
                time.sleep(delay)
                delay *= 2  # Exponential backoff
            else:
                print(f"HTTP error occurred: {e}")
                raise
        except Exception as e:
            print(f"An error occurred: {e}")
            raise
    else:
        raise Exception("Maximum retries reached")

    # Convert TSV data into a list of dictionaries
    lines = tsv_data.splitlines()
    headers = lines[0].split('\t')
    headers.insert(0, 'sequence id')
    results = []
    for line in lines[1:]:
        fields = line.split('\t')
        fields.insert(0, record_id) 
        result = dict(zip(headers, fields))
        # Convert boolean fields from string to actual boolean
        result['is_annotated'] = result['is_annotated'] == 'True'
        result['is_phiblastmatch'] = result['is_phiblastmatch'] == 'True'
        result['is_filtered'] = result['is_filtered'] == 'True'
        result['phiblast'] = result['phiblast'] == 'True'
        result['topodomfilter'] = result['topodomfilter'] == 'True'
        result['taxonfilter'] = result['taxonfilter'] == 'True'
        result['structure'] = result['structure'] == 'True'
        results.append(result)
    return results


def parse_fasta(fasta_file):
    return list(SeqIO.parse(fasta_file, "fasta"))


def process_sequences(sequences):
    all_results = []
    for record in sequences:
        sequence = str(record.seq)
        results = query_elm(sequence, record.id)
        all_results.extend(results)
    return all_results


def main(fasta_file, output_tsv):
    sequences = parse_fasta(fasta_file)
    results = process_sequences(sequences)

    df = pd.DataFrame(results)
    df.to_csv(output_tsv, sep='\t', index=False)


# Example usage
if __name__ == "__main__":
    fasta_file = sys.argv[1]
    output_tsv = "output.tsv"
    main(fasta_file, output_tsv)
