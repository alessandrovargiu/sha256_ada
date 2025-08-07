with Ada.Strings.Wide_Unbounded.Wide_Text_IO;
with Ada.Wide_Text_IO;
with Interfaces;
with Ada.Strings.Fixed;
with Ada.TEXT_IO;
with Ada.Unchecked_Conversion;
with SHA256_TYPES;

package SHA_256 is
    use Interfaces;
    use Ada.Text_IO;
    use SHA256_TYPES;
    ---------------------------------------
	-- Local Variables
	---------------------------------------
    CTX        : SHA256_CTX;
	HASH_LOCAL : UNSGN_BYTE_TYPE_ARRAY32;  
    I    : Integer := Integer'First;

    procedure SHA256_Init (CTX : in out SHA256_CTX);
    procedure SHA256_Transform (CTX : in out SHA256_CTX; DATA : in UNSGN_BYTE_TYPE_ARRAY64);
    procedure SHA256_Update (CTX : in out SHA256_CTX; MSG : in UNSGN_BYTE_TYPE_ARRAY; MSG_LEN : in LONG_WORD);
    procedure SHA256_Final (CTX : in out SHA256_CTX; HASH : out UNSGN_BYTE_TYPE_ARRAY32);

end SHA_256;