library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity AluTest is
   port (
       A, B : in std_logic_vector(7 downto 0);
       ALU_sel : in std_logic_vector(1 downto 0);
       NZVC : out std_logic_vector(3 downto 0);
       deco0, deco1 : out std_logic_vector(6 downto 0)
   );
end AluTest;

architecture arch_AluTest of AluTest is
    signal result : std_logic_vector(7 downto 0);
    signal lower_result : unsigned(3 downto 0);
    signal upper_result : unsigned(3 downto 0);
begin
    Alu_inst: entity work.alu
        port map (
            A => A,
            B => B,
            ALU_sel => ALU_sel,
            result => result,
            NZVC => NZVC
        );

    -- Convertir los segmentos del resultado a tipo unsigned
    lower_result <= unsigned(result(3 downto 0));
    upper_result <= unsigned(result(7 downto 4));

    display_lower: entity work.Displays7Seg4bits
        port map (
            input => lower_result,
            segments => deco0
        );

    display_upper: entity work.Displays7Seg4bits
        port map (
            input => upper_result,
            segments => deco1
        );
end arch_AluTest;
