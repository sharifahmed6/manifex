
import re

def find_duplicates(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Find en_US block
    en_us_match = re.search(r"'en_US':\s*\{(.*?)\},", content, re.DOTALL)
    if en_us_match:
        en_us_block = en_us_match.group(1)
        keys = re.findall(r'"(.*?)"\s*:', en_us_block)
        seen = set()
        dupes = []
        for k in keys:
            if k in seen:
                dupes.append(k)
            seen.add(k)
        print(f"en_US duplicates: {dupes}")

    # Find pl_PL block
    pl_pl_match = re.search(r"'pl_PL':\s*\{(.*?)\},", content, re.DOTALL)
    if pl_pl_match:
        pl_pl_block = pl_pl_match.group(1)
        keys = re.findall(r'"(.*?)"\s*:', pl_pl_block)
        seen = set()
        dupes = []
        for k in keys:
            if k in seen:
                dupes.append(k)
            seen.add(k)
        print(f"pl_PL duplicates: {dupes}")

if __name__ == "__main__":
    find_duplicates(r"c:\Users\shari\my_project\manifex\lib\App\Translation.dart")
