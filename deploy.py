#!/usr/bin/env python

import subprocess
import sys
import tempfile

import jinja2


ZOO_DEFAULT_CFG = """
dataDir=/var/lib/zookeeper
tickTime=2000
clientPort=2181
initLimit=5
syncLimit=2
"""


def main():
    zk_count = int(sys.argv[1])
    template_data = open("docker-compose.yml.j2").read()
    t = jinja2.Template(template_data)
    template_file = tempfile.mkstemp(".yml", dir="./")[1]
    zoo_cfg_file = tempfile.mkstemp(".zoo.cfg", dir="./")[1]
    with open(zoo_cfg_file, "w") as f:
        f.write(ZOO_DEFAULT_CFG)
    compose_data = t.render(zk_server_count=zk_count, zoo_cfg_file=zoo_cfg_file)
    with open(template_file, "w") as f:
        f.write(compose_data)
    subprocess.call(["docker-compose", "-f", template_file, "up"])


if __name__ == "__main__":
    main()
