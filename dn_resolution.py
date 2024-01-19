import socket
import re
import argparse

def extract_domain(url):
    """ Extract the domain name from a URL """
    extracted_domain = re.sub(r'^https?://', '', url).strip()
    print(f"Extracted domain: {extracted_domain}")  # Debug print
    return extracted_domain

def nslookup(domain):
    """ Perform an NS lookup and return the IP address """
    try:
        ip_address = socket.gethostbyname(domain)
        print(f"IP Address for {domain}: {ip_address}")  # Debug print
        return ip_address
    except socket.gaierror as e:
        error_message = f"NS lookup failed for {domain}: {e}"
        print(error_message)  # Debug print
        return error_message

def process_urls(input_file, output_file):
    """ Process URLs from the input file and write results to the output file """
    with open(input_file, 'r') as infile, open(output_file, 'w') as outfile:
        for url in infile:
            print(f"Processing URL: {url.strip()}")  # Debug print
            domain = extract_domain(url)
            ip_address = nslookup(domain)
            outfile.write(f"{domain} - {ip_address}\n")

def main():
    parser = argparse.ArgumentParser(description="Process a list of URLs to find their IP addresses.")
    parser.add_argument("-i", "--input", required=True, help="Input file containing URLs")
    parser.add_argument("-o", "--output", required=True, help="Output file to write the IPs")
    
    args = parser.parse_args()

    process_urls(args.input, args.output)

if __name__ == "__main__":
    main()
