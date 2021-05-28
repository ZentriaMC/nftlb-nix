{ stdenv
, lib
, fetchFromGitHub
, autoreconfHook
, pkg-config
, nftables
, jansson
, libev
, libmnl
}:

stdenv.mkDerivation rec {
  pname = "nftlb";
  version = "c56ca8ebdfcf4e170e0988cdfa3691ceab2f6fc3";

  src = fetchFromGitHub {
    owner = "zevenet";
    repo = pname;
    rev = version;
    sha256 = "1fbyjq6w3kf7zjir3zzyfkhf1w3ihhn65yhnnb1k4bpdqsianpvs";
  };

  nativeBuildInputs = [ autoreconfHook pkg-config ];
  buildInputs = [ nftables jansson libev libmnl ];

  patches = [
    ./patches/0001-Ensure-buf-lvar-is-initialized.patch
    ./patches/0002-Ensure-out-lvar-is-initialized.patch
    ./patches/0003-Fix-memory-leaks-in-net_get_neigh_ether-and-net_get_.patch
    ./patches/0004-Fix-potential-null-pointer-dereference-in-backend_se.patch
    ./patches/0005-Remove-dead-code-causing-memory-leak-in-run_farm_rul.patch
  ];

  meta = with lib; {
    description = "nftables load balancer";
    homepage = "https://github.com/zevenet/nftlb";
    license = licenses.agpl3;
    platforms = platforms.linux;
  };
}
