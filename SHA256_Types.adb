package body SHA256_TYPES is
    use Interfaces;

   -- Functions
   function sig0(x: in WORD) return WORD is
	begin
		return Rotate_Right(x, 7) xor Rotate_Right(x, 18) xor Shift_Right(x, 3);
	end sig0;

	function sig1(x: in WORD) return WORD is
	begin
		return Rotate_Right(x, 17) xor Rotate_Right(x, 19) xor Shift_Right(x, 10);
	end sig1;

	function ep0(x: in WORD) return WORD is
	begin
		return Rotate_Right(x, 2) xor Rotate_Right(x, 13) xor Rotate_Right(x, 22);
	end ep0;

	function ep1(x: in WORD) return WORD is
	begin
		return Rotate_Right(x, 6) xor Rotate_Right(x, 11) xor Rotate_Right(x, 25);
	end ep1;

	function Ch(x: in WORD;
				y: in WORD;
				z: in WORD) return WORD is
	begin
		return (x and y) xor ((not x) and z);
	end Ch;

	function Maj(x: in WORD;
				y: in WORD;
				z: in WORD) return WORD is
	begin
    	return (x and y) xor ((x and z) xor (y and z));
	end Maj;

    function To_Hex(Value : BYTE) return String is
        Hex_Digits : constant String := "0123456789ABCDEF";
        High : Natural := Natural(Value / 16);
        Low  : Natural := Natural(Value mod 16);
    begin
        return Hex_Digits(High + 1) & Hex_Digits(Low + 1);
    end To_Hex;

    function To_Hex(Value : WORD) return String is
      Hex_Digits : constant String := "0123456789ABCDEF";
      Result : String(1..8);  -- 32 bits = 8 hex digits
      Temp : WORD := Value;
   begin
      -- Process from right to left (least significant to most significant)
      for I in reverse Result'Range loop
         Result(I) := Hex_Digits(Natural(Temp mod 16) + 1);
         Temp := Temp / 16;
      end loop;
      return Result;
   end To_Hex;


end SHA256_TYPES;

