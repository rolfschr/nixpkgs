{ stdenv, pythonPackages, mopidy, mopidy-local-images }:

pythonPackages.buildPythonApplication rec {
  pname = "Mopidy-Iris";
  version = "3.20.0";

  src = pythonPackages.fetchPypi {
    inherit pname version;
    sha256 = "1fva5ysik3af3x74l6059ngwsxrk9g6ml47wr5ck536k66i025ar";
  };

  propagatedBuildInputs = [
    mopidy
    mopidy-local-images
  ] ++ (with pythonPackages; [
    configobj
    pylast
    spotipy
    raven
    tornado
  ]);

  postPatch = "sed -i /tornado/d setup.py";

  # no tests implemented
  doCheck = false;

  meta = with stdenv.lib; {
    homepage = https://github.com/jaedb/Iris;
    description = "A fully-functional Mopidy web client encompassing Spotify and many other backends";
    license = licenses.asl20;
    maintainers = [ maintainers.rvolosatovs ];
  };
}
