#/bin/zsh

if ! command -v yq &> /dev/null; then
  echo "Error: yq is not installed. Please install it using 'brew install yq'."
  return 1
fi

if ! command -v kubectl &> /dev/null; then
  echo "Error: kubectl is not installed. Please install it using 'brew install kubectl'."
  return 1
fi

DEFAULT_YAML_FILE="$HOME/.config/adobe/profiles.yaml"

kprof() {
  if [[ "$1" == "--help" || "$1" == "help" ]]; then
    echo "Usage: kprof <project> <env> <region>"
    echo ""
    echo "Switches the Kubernetes cluster and namespace based on the project, environment, and region."
    echo "Projects, environments, and regions are defined in a YAML file at:"
    echo "\t default: $DEFAULT_YAML_FILE"
    echo ""
    echo "Arguments:"
    echo "  <project>    The project name."
    echo "  <env>        The environment (e.g., int, stage, prod)."
    echo "  <region>     The region (e.g., va6, or2, ind1)."
    echo ""
    echo "Commands:"
    echo "  --help, help  Show this help message."
    return 0
  fi

  local project="$1"
  local env="$2"
  local region="$3"
  local cluster namespace

  if [[ $# -ne 3 ]]; then
    echo "Usage: kprof <project> <env> <region>"
    return 1
  fi

  local yaml_file="$DEFAULT_YAML_FILE"
  if [[ ! -f "$yaml_file" ]]; then
    echo "Error: YAML file not found at '$yaml_file'."
    return 1
  fi

  # Get the cluster and namespace from the YAML file
  local entry="$project.$env.$region"
  cluster=$(yq ".projects.$entry.cluster" "$yaml_file")
  namespace=$(yq ".projects.$entry.namespace" "$yaml_file")

  if [[ -z "$cluster" ]]; then
    echo "Error: Cluster '$cluster' not found in the YAML file at yamlpath '.projects.$entry.cluster'."
    return 1
  fi

  if [[ -z "$namespace" ]]; then
    echo "Error: Namespace '$namespace' not found in the YAML file at yamlpath '.projects.$entry.namespace'."
    return 1
  fi

  # Switch Kubernetes cluster and namespace
  kubectl config set-context "$cluster" --namespace="$namespace" >/dev/null 2>&1
  kubectl config use-context "$cluster" >/dev/null 2>&1
  
  if [[ $? -ne 0 ]]; then
    echo "Error: Unable to set cluster '$cluster'."
    return 1
  fi

  echo "Switched to cluster '$cluster' and namespace '$namespace'."
}

kprof "$@"
