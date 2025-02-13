{pkgs, lib}: device_list: let 
    id_amount = builtins.toString (lib.lists.length device_list);
    id_file = pkgs.stdenv.mkDerivation rec { 
        name = "gen-syncthing-id";
        src = ./.;
        script = pkgs.writeShellScriptBin "gen_syncthing_ids" /*bash*/ ''
            out_str=""
            for n in $(seq 1 ${id_amount})
                do
                    random_string=$(head -c 32 /dev/urandom | base64)
                        sha256_hash=$(echo -n "$random_string" | sha256sum | awk '{print $1}')
                        base32_encoded=$(echo -n "$sha256_hash" | xxd -r -p | base32)
                        id=$(echo "$base32_encoded"| sed 's/=*$//'| ./luhn32)  
                        out_str+=$id
                        out_str+="\n"
                        done
                        echo -e $out_str 
                        '';

                buildInputs = [pkgs.xxd pkgs.coreutils pkgs.go script ];
                buildPhase = /*bash*/ ''
                    export HOME=$TEMPDIR
                    go build -o luhn32 luhn32.go
                    '';
                installPhase = /*bash*/''
                    gen_syncthing_ids > $out
                    '';
    };



    id_list = id_file.outPath 
        |> builtins.readFile
        |> lib.splitString "\n"
        |> builtins.filter (line: line != "");

    result = lib.zipListsWith (a: b: { name = a; id = b; }) device_list id_list
        |> (devices: lib.forEach devices (device: { name = "${device.name}"; value = {id =device.id;};}))
        |> builtins.listToAttrs;
        
    
in result 
    
