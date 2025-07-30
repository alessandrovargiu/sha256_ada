
package SHA256_TYPES is

   --type UNSGN_32_BIT_TYPE is range 0 .. (2**32)-1;
   --type UNSGN_8_BIT_TYPE is range 0 .. (2**8)-1;

   -- Modular type enables shift operations
   type UNSGN_64_BIT_TYPE is mod 2**64;
   type UNSGN_32_BIT_TYPE is mod 2**32;
   type UNSGN_8_BIT_TYPE is mod 2**8;

   -- unconstrained array type
   type UNSGN_BYTE_TYPE_ARRAY is array (Positive range <>) of UNSGN_8_BIT_TYPE;

   type UNSGN_32_BIT_TYPE_ARRAY64 is array (1 .. 64) of UNSGN_32_BIT_TYPE;
   type UNSGN_32_BIT_TYPE_ARRAY8 is array (1 .. 8) of UNSGN_32_BIT_TYPE;  
   type UNSGN_8_BIT_TYPE_ARRAY64 is array (1 .. 64) of UNSGN_8_BIT_TYPE;  

   -- Context record containing state of the computation
   type SHA256_CTX is record
      data : UNSGN_8_BIT_TYPE_ARRAY64;
      datalen : UNSGN_32_BIT_TYPE;
      bitlen: UNSGN_64_BIT_TYPE;
      state : UNSGN_32_BIT_TYPE_ARRAY8;
   end record;

   -- First 32 bits of the fractional parts of the square roots
   -- of the first 8 prime numbers
   H8: constant UNSGN_32_BIT_TYPE_ARRAY8 := 
   (
      0 => 16#6a09e667#, 
		1 => 16#bb67ae85#, 
		2 => 16#3c6ef372#, 
		3 => 16#a54ff53a#,
		4 => 16#510e527f#, 
		5 => 16#9b05688c#, 
		6 => 16#1f83d9ab#, 
		7 => 16#5be0cd19#
   );

   -- First 32 bits of the fractional parts of the cube roots of
   --  the first 64 prime numbers
   K64: constant UNSGN_32_BIT_TYPE_ARRAY64 :=
   (
      0  => 16#428a2f98#, 1  => 16#71374491#, 2  => 16#b5c0fbcf#, 3  => 16#e9b5dba5#,
      4  => 16#3956c25b#, 5  => 16#59f111f1#, 6  => 16#923f82a4#, 7  => 16#ab1c5ed5#,
      8  => 16#d807aa98#, 9  => 16#12835b01#, 10 => 16#243185be#, 11 => 16#550c7dc3#,
      12 => 16#72be5d74#, 13 => 16#80deb1fe#, 14 => 16#9bdc06a7#, 15 => 16#c19bf174#,
      16 => 16#e49b69c1#, 17 => 16#efbe4786#, 18 => 16#0fc19dc6#, 19 => 16#240ca1cc#,
      20 => 16#2de92c6f#, 21 => 16#4a7484aa#, 22 => 16#5cb0a9dc#, 23 => 16#76f988da#,
      24 => 16#983e5152#, 25 => 16#a831c66d#, 26 => 16#b00327c8#, 27 => 16#bf597fc7#,
      28 => 16#c6e00bf3#, 29 => 16#d5a79147#, 30 => 16#06ca6351#, 31 => 16#14292967#,
      32 => 16#27b70a85#, 33 => 16#2e1b2138#, 34 => 16#4d2c6dfc#, 35 => 16#53380d13#,
      36 => 16#650a7354#, 37 => 16#766a0abb#, 38 => 16#81c2c92e#, 39 => 16#92722c85#,
      40 => 16#a2bfe8a1#, 41 => 16#a81a664b#, 42 => 16#c24b8b70#, 43 => 16#c76c51a3#,
      44 => 16#d192e819#, 45 => 16#d6990624#, 46 => 16#f40e3585#, 47 => 16#106aa070#,
      48 => 16#19a4c116#, 49 => 16#1e376c08#, 50 => 16#2748774c#, 51 => 16#34b0bcb5#,
      52 => 16#391c0cb3#, 53 => 16#4ed8aa4a#, 54 => 16#5b9cca4f#, 55 => 16#682e6ff3#,
      56 => 16#748f82ee#, 57 => 16#78a5636f#, 58 => 16#84c87814#, 59 => 16#8cc70208#,
      60 => 16#90befffa#, 61 => 16#a4506ceb#, 62 => 16#bef9a3f7#, 63 => 16#c67178f2#
   );

end SHA256_TYPES;





