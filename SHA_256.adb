-- SHA256 ADA implementation
package body SHA_256 is
    
    --------------------------------------
    -- SHA_256 - Init, Transform, Final
    --------------------------------------

	procedure SHA256_Init (CTX : in out SHA256_CTX) is
	begin
        for I in 0 .. 63 loop
            CTX.data(I) := BYTE'First;
        end loop;
		CTX.State   := H8;
		CTX.Datalen := 0;
        CTX.Bitlen  := 0;
	end SHA256_Init;

	procedure SHA256_Transform
		(CTX  : in out SHA256_CTX;
		 DATA : in     UNSGN_BYTE_TYPE_ARRAY64)
	is
		MSG : array (0 .. 64) of WORD;
		A, B, C, D, E, F, G, H, T1, T2 : WORD;
		J : Integer := 0;
	begin
		for I in 0 .. 15 loop
			-- First 16 words from data to msg (requires shift)
			MSG(I) :=
			WORD (
				Shift_Left (WORD (DATA(J)), 24) or
				Shift_Left (WORD (DATA(J + 1)), 16) or
				Shift_Left (WORD (DATA(J + 2)), 8) or
				WORD (DATA(J + 3))
			);
			J := J + 4;
		end loop;

		for I in 16 .. 63 loop
			MSG(I) := Sig1 (MSG(I - 2)) + MSG(I - 7) + Sig0 (MSG(I - 15)) + MSG(I - 16);
		end loop;

		A := CTX.State(0);
		B := CTX.State(1);
		C := CTX.State(2);
		D := CTX.State(3);
		E := CTX.State(4);
		F := CTX.State(5);
		G := CTX.State(6);
		H := CTX.State(7);     

		for I in 0 .. 63 loop
			T1 := H + Ep1(E) + Ch(E, F, G) + K64(I) + MSG(I);
			T2 := Ep0(A) + Maj(A, B, C);
			H  := G;
			G  := F;
			F  := E;
			E  := D + T1;
			D  := C;
			C  := B;
			B  := A;
			A  := T1 + T2;
		end loop;

		CTX.State(0) := Ctx.State(0) + A;
		CTX.State(1) := Ctx.State(1) + B;
		CTX.State(2) := Ctx.State(2) + C;
		CTX.State(3) := Ctx.State(3) + D;
		CTX.State(4) := Ctx.State(4) + E;
		CTX.State(5) := Ctx.State(5) + F;
		CTX.State(6) := Ctx.State(6) + G;
		CTX.State(7) := Ctx.State(7) + H;
	end SHA256_Transform;

	procedure SHA256_Update (
		CTX     : in out SHA256_CTX;
		MSG     : in     UNSGN_BYTE_TYPE_ARRAY;
		MSG_LEN : in     LONG_WORD) is
		I : LONG_WORD := LONG_WORD'First;
        -- Copy of MSG to allow 0-based indexing when array is passed in slices
        MSG_LOCAL : UNSGN_BYTE_TYPE_ARRAY (0 .. Integer(MSG_LEN)-1) := MSG;
	begin
		for I in 0 .. Msg_Len - 1 loop
			CTX.Data (Integer (CTX.Datalen)) := MSG_LOCAL (Integer (I));
			CTX.Datalen := CTX.Datalen + 1;

			if CTX.Datalen = 64 then
				SHA256_Transform (CTX, CTX.Data);
				CTX.Bitlen := CTX.Bitlen + 512;
				CTX.Datalen := 0;
			end if;
           
		end loop;
	end SHA256_Update;

	procedure SHA256_Final (
		CTX  : in out SHA256_CTX;
		HASH : out    UNSGN_BYTE_TYPE_ARRAY32) is
		I : WORD := WORD'First;
	begin
		I := CTX.Datalen;
		if CTX.Datalen < 56 then
			CTX.Data (Integer (I)) := 16#80#;
			I := I + 1;
			while I < 56 loop
				CTX.Data (Integer (I)) := 16#00#;
				I := I + 1;
			end loop;
		else
			CTX.Data (Integer (I)) := 16#80#;
			I := I + 1;
			while I < 64 loop
				CTX.Data (Integer (I)) := 16#00#;
				I := I + 1;
			end loop;
			SHA256_Transform (CTX, CTX.Data);
			CTX.Data (0 .. 56) := (others => 0);
		end if;

		-- Append total bit length of message into it
		-- Using "and 0xFF" to select only the required bytes
		CTX.Bitlen := CTX.Bitlen + LONG_WORD (CTX.Datalen * 8);
		for I in 0 .. 7 loop
			CTX.Data (63 - I) := BYTE (Shift_Right (WORD (CTX.Bitlen), I * 8) and 16#FF#);
		end loop;

		SHA256_Transform (CTX, CTX.Data);

		-- Convert to little endian
		for I in 0 .. 3 loop
			HASH_LOCAL (I)      := BYTE (Shift_Right (WORD (CTX.State (0)), (24 - I * 8)) and 16#FF#);
			HASH_LOCAL (I + 4)  := BYTE (Shift_Right (WORD (CTX.State (1)), (24 - I * 8)) and 16#FF#);
			HASH_LOCAL (I + 8)  := BYTE (Shift_Right (WORD (CTX.State (2)), (24 - I * 8)) and 16#FF#);
			HASH_LOCAL (I + 12) := BYTE (Shift_Right (WORD (CTX.State (3)), (24 - I * 8)) and 16#FF#);
			HASH_LOCAL (I + 16) := BYTE (Shift_Right (WORD (CTX.State (4)), (24 - I * 8)) and 16#FF#);
			HASH_LOCAL (I + 20) := BYTE (Shift_Right (WORD (CTX.State (5)), (24 - I * 8)) and 16#FF#);
			HASH_LOCAL (I + 24) := BYTE (Shift_Right (WORD (CTX.State (6)), (24 - I * 8)) and 16#FF#);
			HASH_LOCAL (I + 28) := BYTE (Shift_Right (WORD (CTX.State (7)), (24 - I * 8)) and 16#FF#);
		end loop;
		HASH := HASH_LOCAL;
	end SHA256_Final;

end SHA_256;