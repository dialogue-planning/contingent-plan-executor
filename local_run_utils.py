from hovor.configuration.json_configuration_provider import JsonConfigurationProvider
from environment import initialize_local_environment
from time import sleep
import requests
import subprocess
import jsonpickle

def create_validate_json_config_prov(output_files_path):
    configuration_provider = JsonConfigurationProvider(f"{output_files_path}/data")
    # test on recoded provider
    json = jsonpickle.encode(configuration_provider)
    configuration_provider = jsonpickle.decode(json)
    configuration_provider.check_all_action_builders()
    return configuration_provider

def _run_rasa_model_server(output_files_path):
    subprocess.Popen(["rasa", "run", "--enable-api", "-m", f"{output_files_path}/nlu_model.tar.gz"])
    while True:
        try:
            requests.post("http://localhost:5005/model/parse", json={"text": ""})
        except ConnectionError:
            sleep(0.1)
        else:
            break

def initialize_local_run(output_files_path, get_cfg: bool = True):
    initialize_local_environment()
    _run_rasa_model_server(output_files_path)
    if get_cfg:
        return create_validate_json_config_prov(output_files_path)
