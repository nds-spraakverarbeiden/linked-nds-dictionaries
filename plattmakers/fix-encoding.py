from ftfy import fix_encoding
import sys
import argparse

args=argparse.ArgumentParser(description="try to fix broken encodings, one line at a time")
args.add_argument("files", nargs="*", type=str, help="files to read from, if none are provided, read from stdin", default=[])
args.add_argument("-s","--silent", action="store_true", help="suppress default status messages")
args=args.parse_args()

if args.files==None or len(args.files)==0:
	if not args.silent:
		sys.stderr.write("fix-encoding.py: reading from stdin, close with <CTRL>+D or EOL\n")
		sys.stderr.flush()
	args.files=[sys.stdin]

for file in args.files:
	if isinstance(file,str):
		if not args.silent:
			sys.stderr.write("fix-encoding.py: reading "+file+"\n")
			sys.stderr.flush()
		file=open(file,"rt", errors="ignore")
	for line in file:
		line=fix_encoding(line)
		print(line.rstrip("\r\n"))
	file.close()
