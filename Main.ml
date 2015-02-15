let version = "0.2"
let getFormat f =
	let ic = (open_in_bin f) in
	let rec loop ch a =
		try
			match a with
			| [|0xff;0xd8|] -> "jpg"
			| [|0x89;0x50;0x4e;0x47;0x0d;0x0a;0x1a;0x0a|] -> "png"
			| [|0x47;0x49;0x46;0x38;0x37;0x61|] -> "gif"
            | [|0x47;0x49;0x46;0x38;0x39;0x61|] -> "gif"
			| [|0x42;0x4d|] -> "bmp"
			| a -> if Array.length a > 10 then "unknown" else loop ch (Array.append a [|input_byte ic|])
		with
			End_of_file -> "unknown" in
	let result = loop ic [||] in
	close_in ic;
	result;;

let () =
	if Sys.argv.(1) = "-v" then Printf.printf "%s\n" version
	else
		if 2 = Array.length Sys.argv then
			let file = Sys.argv.(1) in
			print_string (getFormat file)
		else
			for i=1 to Array.length Sys.argv - 1 do
				let file = Sys.argv.(i) in
				Printf.printf "%s\t%s\n" (getFormat file) file
			done;;
