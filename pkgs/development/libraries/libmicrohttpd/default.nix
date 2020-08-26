{ stdenv, fetchurl, libgcrypt, curl, gnutls, pkgconfig, libiconv, libintl }:

stdenv.mkDerivation rec {
  pname = "libmicrohttpd";
  version = "0.9.71";

  src = fetchurl {
    url = "mirror://gnu/libmicrohttpd/${pname}-${version}.tar.gz";
    sha256 = "10mii4mifmfs3v7kgciqml7f0fj7ljp0sngrx64pnwmgbzl4bx78";
  };

  outputs = [ "out" "dev" "devdoc" "info" ];
  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ libgcrypt curl gnutls libiconv libintl ];

  preCheck = ''
    # Since `localhost' can't be resolved in a chroot, work around it.
    sed -ie 's/localhost/127.0.0.1/g' src/test*/*.[ch]
  '';

  # Disabled because the tests can time-out.
  doCheck = false;

  meta = with stdenv.lib; {
    description = "Embeddable HTTP server library";

    longDescription = ''
      GNU libmicrohttpd is a small C library that is supposed to make
      it easy to run an HTTP server as part of another application.
    '';

    license = licenses.lgpl2Plus;

    homepage = "https://www.gnu.org/software/libmicrohttpd/";

    maintainers = with maintainers; [ eelco vrthra fpletz ];
    platforms = platforms.unix;
  };
}
