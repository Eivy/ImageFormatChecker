let version = "0.1"
let getFormat f =
	let ic = (open_in_bin f) in
	let rec loop ch a =
		try
			match a with
			| [|255;216|] -> "jpg"
			| [|137;80;78;71;13;10;26;10|] -> "png"
			| [|71;73;70;56;55;97|] -> "gif"
			| [|71;73;70;56;57;97|] -> "gif"
			| [|66;77|] -> "bmp"
			| a -> if Array.length a > 10 then "unknown" else loop ch (Array.append a [|input_byte ic|])
		with
			End_of_file -> "unknown" in
	let result = loop ic [||] in
	close_in ic;
	result;;

let () =
	if Sys.argv.(1) = "-v" then Printf.printf "%s\n" version
	else
        let file = Sys.argv.(1) in
        print_string (getFormat file);;
