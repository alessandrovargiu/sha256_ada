
with Ada.Strings.Wide_Unbounded.Wide_Text_IO;
with Ada.Text_IO;
with Interfaces;
with SHA256_TYPES;
    use SHA256_TYPES;
with SHA_256;
    use SHA_256;

procedure SHA_256_test is
    use Ada.Text_IO;
    -- Test vectors from NIST
    
    TEST_VECTOR_1 : constant String := "abc";
    TEST_VECTOR_2 : constant String := "The quick brown fox jumps over the lazy dog.";
    TEST_VECTOR_3 : constant String := "SHA-256 is a one-way cryptographic hash function";
    TEST_VECTOR_2_HASH : UNSGN_BYTE_TYPE_ARRAY32 :=
    (  
        0  => 16#ef#,  1  => 16#53#,  2  => 16#7f#,  3  => 16#25#,
        4  => 16#c8#,  5  => 16#95#,  6  => 16#bf#,  7  => 16#a7#,
        8  => 16#82#,  9  => 16#52#, 10  => 16#65#, 11  => 16#29#,
        12  => 16#a9#, 13  => 16#b6#, 14  => 16#3d#, 15  => 16#97#,
        16  => 16#aa#, 17  => 16#63#, 18  => 16#15#, 19  => 16#64#,
        20  => 16#d5#, 21  => 16#d7#, 22  => 16#89#, 23  => 16#c2#,
        24  => 16#b7#, 25  => 16#65#, 26  => 16#44#, 27  => 16#8c#,
        28  => 16#86#, 29  => 16#35#, 30  => 16#fb#, 31  => 16#6c#
    );
    
    INPUT_TEXT_ARRAY : UNSGN_BYTE_TYPE_ARRAY (0 .. TEST_VECTOR_2'Length - 1) := (others => BYTE'First);
    I    : Integer := Integer'First;
	HASH : UNSGN_BYTE_TYPE_ARRAY32 := (others => BYTE'First);
	PASS : Boolean := False;
begin

    -- Main program logic starts here
	for I in TEST_VECTOR_2'Range loop
		INPUT_TEXT_ARRAY (I-1) := BYTE (Character'Pos (TEST_VECTOR_2 (I)));
	end loop;

	SHA256_Init (CTX);
	SHA256_Update (CTX, INPUT_TEXT_ARRAY, INPUT_TEXT_ARRAY'Length);
	SHA256_Final (CTX, HASH);
   
   Put("---- TEST 1 ----");
   New_Line;
    --Print produced HASH for debugging purposes
    for I in 0 .. HASH'Length - 1 loop
        Ada.Text_IO.Put (" 0x" & SHA256_Types.To_Hex (HASH(I)));
    end loop;
    New_Line;

    -- Print correct hash
    for I in 0 .. TEST_VECTOR_2_HASH'Length - 1 loop
        Ada.Text_IO.Put (" 0x" & SHA256_Types.To_Hex (TEST_VECTOR_2_HASH(I)));
    end loop;
    New_Line;

	PASS := (HASH = TEST_VECTOR_2_HASH);
    Put_Line (Boolean'Image (PASS));

    -- STREAM-based processing --
    Put("---- TEST 2 ----");
    New_Line;

    SHA256_Init(CTX);
    -- Send two BYTES at a time
    for I in 0 .. INPUT_TEXT_ARRAY'Length / 2 - 1 loop
        SHA256_Update(CTX, INPUT_TEXT_ARRAY(I*2 .. I*2 + 2 - 1), 2);
    end loop;
    SHA256_Final(CTX, HASH);

    --Print produced HASH for debugging purposes
    for I in 0 .. HASH'Length - 1 loop
        Put (" 0x" & SHA256_Types.To_Hex (HASH(I)));
    end loop;
    New_Line;

    -- Print correct hash
    for I in 0 .. TEST_VECTOR_2_HASH'Length - 1 loop
        Put (" 0x" & SHA256_Types.To_Hex (TEST_VECTOR_2_HASH(I)));
    end loop;
    New_Line;

    PASS := (HASH = TEST_VECTOR_2_HASH);
    Put_Line (Boolean'Image (PASS));

end SHA_256_test;



























