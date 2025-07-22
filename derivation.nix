{ python3Packages }:
with python3Packages;
buildPythonApplication {
  pname = "pulse-volume-watcher";
  version = "1.0";
  propagatedBuildInputs = [ pulsectl ];
  src = ./.;
  pyproject = true;
  build-system = [ setuptools ];
}
