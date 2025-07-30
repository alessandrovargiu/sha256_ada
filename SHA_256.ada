-- SHA256 ADA implementation

with SHA256_TYPES;
	use type SHA256_TYPES.SHA256_CTX;
	use type SHA256_TYPES.UNSGN_32_BIT_TYPE;
	use type SHA256_TYPES.UNSGN_32_BIT_TYPE_ARRAY64;

-- Main program procedure
procedure main is

	-- Functions
	function ROTLEFT
		(X, Y: SHA256_TYPES.UNSGN_32_BIT_TYPE) return SHA256_TYPES.UNSGN_32_BIT_TYPE is
	begin
		return;
	end ROTLEFT;

	-- Variables
	ctx : SHA256_TYPES.SHA256_CTX;
	hash: SHA256_TYPES.UNSGN_32_BIT_TYPE;

	procedure SHA256_init(ctx: SHA256_TYPES.SHA256_CTX) is
	begin
		ctx.state := SHA256_TYPES.H8;
		ctx.datalen := 0;
    end SHA256_init;

	procedure SHA256_transform(ctx: SHA256_TYPES.SHA256_CTX;
								data: SHA256_TYPES.UNSGN_8_BIT_TYPE_ARRAY64) is
		m : array (0 .. 64) of SHA256_TYPES.UNSGN_32_BIT_TYPE;
		a, b, c, d, e, f, g, h : SHA256_TYPES.UNSGN_32_BIT_TYPE;
	begin
		
		for i in 1 .. 16 loop
			-- first 16 words by data from m (requires shift)
		end loop;

		for i in 16 .. 64 loop
			-- fill the rest of array running SIG0 and SIG1 ops (rotations)
		end loop;

		a := ctx.state(0); b := ctx.state(1);
		c := ctx.state(2); d := ctx.state(3);
		e := ctx.state(4); f := ctx.state(5);
		g := ctx.state(6); h := ctx.state(7);

		for i in 0 .. 64 loop
			-- S1(), ch(), S0(), maj()
			-- main compression function
		end loop;

		ctx.state(0) := a; ctx.state(1) := b;
		ctx.state(2) := c; ctx.state(0) := d;	
		ctx.state(4) := e; ctx.state(5) := f;
		ctx.state(6) := g; ctx.state(7) := h;

	end SHA256_transform;



	procedure SHA256_update(ctx: SHA256_TYPES.SHA256_CTX;
							msg: SHA256_TYPES.UNSGN_BYTE_TYPE_ARRAY;
							msg_len: SHA256_TYPES.UNSGN_64_BIT_TYPE) is
		i: SHA256_TYPES.UNSGN_64_BIT_TYPE;
	begin
		for i in 1 .. msg_len loop
			ctx.data(ctx.datalen++) := msg(i);
			if(ctx.datalen == 64) then
				SHA256_transform(ctx, ctx.data);
				ctx.bitlen := ctx.bitlen + 512;
				ctx.datalen := 0;
			end if;
		end loop;
	end SHA256_update;

	procedure SHA256_final(ctx: SHA256_TYPES.SHA256_CTX;
							hash: SHA256_TYPES.UNSGN_32_BIT_TYPE) is
		i: SHA256_TYPES.UNSGN_32_BIT_TYPE;
	begin
		i := ctx.datalen;
		if(ctx.datalen < 56) then
			ctx.data(i++) := 16#80#;
			while(i < 56) loop
				ctx.data(i++) := 16#00#;
			end loop;
		else
			ctx.data(i++) := 16#80#;
			while (i < 64) loop
				ctx.data(i++) := 16#00#;
			end loop;
			SHA256_transform(ctx, ctx.data);
			
		end if;

	end SHA256_final;

begin
	-- Main program logic starts here
   
   
   
      
end main;