import json
import pathlib

import matplotlib.pyplot as plt

import hotware

plt.rc("font", family="Helvetica World")

this_dir = pathlib.Path(__file__).resolve().parent
with open(this_dir / "groups.json") as f:
    data = json.load(f)


for group_name, group in data.items():
    filenames = [
        this_dir / "data" / (repo.replace("/", "_") + ".json") for repo in group
    ]

    hotware.plot(filenames, cut=0.05)
    plt.title("Number of GitHub stars", fontsize=14)

    # hotware.plot_per_day(filenames)
    # plt.title("Daily number of GitHub stars", fontsize=14)

    plt.show()
    # plt.savefig("github-" + group_name + ".svg", transparent=True, bbox_inches="tight")
    # plt.close()
