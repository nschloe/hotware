import json
import pathlib

import stacktags


def update_groups():
    this_dir = pathlib.Path(__file__).resolve().parent
    with open(this_dir / "groups.json") as f:
        data = json.load(f)

    for group in data.values():
        print()
        for tag in group:
            # print(tag, "...")
            stacktags.stackoverflow.update_file(
                this_dir / "data" / (tag + ".json"),
                tag=tag,
                license="CC BY",
                creator="Nico Schlömer",
            )


if __name__ == "__main__":
    update_groups()
