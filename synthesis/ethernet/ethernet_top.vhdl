LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY ethernet_top IS
    GENERIC (
        RESET_RELEASE_CNT : INTEGER := 100_000_000
    );
    PORT (
        -- system clock 100 MHz
        clk_100mhz_p : IN STD_LOGIC;
        clk_100mhz_n : IN STD_LOGIC;

        -- SFP reference clock  156.25 MHz
        sfp_mgt_refclk_p : IN STD_LOGIC;
        sfp_mgt_refclk_n : IN STD_LOGIC;

        sfp_tx_1_p : OUT STD_LOGIC;
        sfp_tx_1_n : OUT STD_LOGIC;
        sfp_rx_1_p : IN STD_LOGIC;
        sfp_rx_1_n : IN STD_LOGIC;

        -- SFP LEDs
        sfp_led : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);

        -- four LEDs on the side / top
        led : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END ethernet_top;

ARCHITECTURE behaviour OF ethernet_top IS
    SIGNAL clk_100MHz     : STD_LOGIC;
    SIGNAL sfp_mgt_refclk : STD_LOGIC;

    SIGNAL sys_reset                : STD_LOGIC;
    SIGNAL liteeth_reset            : STD_LOGIC;
    SIGNAL liteeth_reset_metastable : STD_LOGIC;
    SIGNAL reset_n                  : STD_LOGIC;

    COMPONENT liteeth_core IS
        PORT (
            sgmii_link_up : OUT STD_LOGIC;
            sgmii_refclk  : IN STD_LOGIC;

            sgmii_rst : IN STD_LOGIC;
            sgmii_rxn : IN STD_LOGIC;
            sgmii_rxp : IN STD_LOGIC;
            sgmii_txn : OUT STD_LOGIC;
            sgmii_txp : OUT STD_LOGIC;

            sys_clock : IN STD_LOGIC;
            sys_reset : IN STD_LOGIC;

            udp0_ip_address : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
            udp0_udp_port   : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

            udp0_sink_data  : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            udp0_sink_last  : IN STD_LOGIC;
            udp0_sink_ready : OUT STD_LOGIC;
            udp0_sink_valid : IN STD_LOGIC;

            udp0_source_data  : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
            udp0_source_error : OUT STD_LOGIC;
            udp0_source_last  : OUT STD_LOGIC;
            udp0_source_ready : IN STD_LOGIC;
            udp0_source_valid : OUT STD_LOGIC;

            udp1_ip_address : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
            udp1_udp_port   : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

            udp1_sink_data  : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            udp1_sink_last  : IN STD_LOGIC;
            udp1_sink_ready : OUT STD_LOGIC;
            udp1_sink_valid : IN STD_LOGIC;

            udp1_source_data  : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
            udp1_source_error : OUT STD_LOGIC;
            udp1_source_last  : OUT STD_LOGIC;
            udp1_source_ready : IN STD_LOGIC;
            udp1_source_valid : OUT STD_LOGIC

        );
    END COMPONENT; -- liteeth_core

BEGIN
    ----------------------------------------------------------------------------
    -- create differential clock buffer
    IBUFGDS_0 : ENTITY work.IBUFGDS
        PORT MAP(
            I  => clk_100mhz_p, -- normal input
            IB => clk_100mhz_n, -- inverted input
            O  => clk_100MHz    -- output
        );

    IBUFGDS_1 : ENTITY work.IBUFGDS
        PORT MAP(
            I  => sfp_mgt_refclk_p, -- normal input
            IB => sfp_mgt_refclk_n, -- inverted input
            O  => sfp_mgt_refclk    -- output
        );

    -- create reference clock for GTY
    -- IBUFDS_GTE4_0 : ENTITY work.IBUFDS_GTE4
    --     GENERIC MAP(
    --         REFCLK_EN_TX_PATH => '0',   -- Refer to Transceiver User Guide.
    --         REFCLK_HROW_CK_SEL => "10", -- ODIV2 deactivated
    --         REFCLK_ICNTL_RX => "00"     -- Refer to Transceiver User Guide.
    --     )
    --     PORT MAP(
    --         O     => sgmii_refclk,
    --         ODIV2 => OPEN,
    --         CEB   => '0',
    --         I     => sfp_mgt_clk_p,
    --         IB    => sfp_mgt_clk_n
    --     );

    ----------------------------------------------------------------------------
    -- RESET
    reset_generator_0 : ENTITY work.reset_generator
        GENERIC MAP(
            RESET_RELEASE_CNT => RESET_RELEASE_CNT
        )
        PORT MAP(
            clk     => sfp_mgt_refclk,
            reset   => sys_reset,
            reset_n => reset_n
        );

    liteeth_reset <= sys_reset;

    --p_liteeth_reset : PROCESS (sfp_mgt_refclk) BEGIN
    --    IF rising_edge(sfp_mgt_refclk) THEN
    --        liteeth_reset_metastable <= sys_reset;
    --        liteeth_reset            <= liteeth_reset_metastable;
    --    END IF;
    --END PROCESS p_liteeth_reset;

    liteeth_core_0 : liteeth_core
    PORT MAP(
        sgmii_link_up => sfp_led(1),
        sgmii_refclk  => sfp_mgt_refclk,

        sgmii_rst => liteeth_reset,

        sgmii_rxn => sfp_rx_1_n,
        sgmii_rxp => sfp_rx_1_p,
        sgmii_txn => sfp_tx_1_n,
        sgmii_txp => sfp_tx_1_p,

        sys_clock => sfp_mgt_refclk,
        sys_reset => liteeth_reset,

        udp0_ip_address => "00000000000000000000000000000000",
        udp0_udp_port   => "0000000000000000",

        udp0_sink_data  => "00000000",
        udp0_sink_last  => '0',
        udp0_sink_ready => OPEN,
        udp0_sink_valid => '0',

        udp0_source_data  => OPEN,
        udp0_source_error => OPEN,
        udp0_source_last  => OPEN,
        udp0_source_ready => '0',
        udp0_source_valid => OPEN,

        udp1_ip_address => "00000000000000000000000000000000",
        udp1_udp_port   => "0000000000000000",

        udp1_sink_data  => "00000000",
        udp1_sink_last  => '0',
        udp1_sink_ready => OPEN,
        udp1_sink_valid => '0',

        udp1_source_data  => OPEN,
        udp1_source_error => OPEN,
        udp1_source_last  => OPEN,
        udp1_source_ready => '0',
        udp1_source_valid => OPEN
    );

    ----------------------------------------------------------------------------
    blink_0 : ENTITY work.blink
        GENERIC MAP(
            max_count => 100_000_000
        )
        PORT MAP(
            clk       => clk_100MHz,
            blink_out => LED(0)
        );
    blink_1 : ENTITY work.blink
        GENERIC MAP(
            max_count => 50_000_000
        )
        PORT MAP(
            clk       => clk_100MHz,
            blink_out => LED(1)
        );
    blink_2 : ENTITY work.blink
        GENERIC MAP(
            max_count => 200_000_000
        )
        PORT MAP(
            clk       => clk_100MHz,
            blink_out => LED(2)
        );
    blink_3 : ENTITY work.blink
        GENERIC MAP(
            max_count => 75_000_000
        )
        PORT MAP(
            clk       => clk_100MHz,
            blink_out => LED(3)
        );

END ARCHITECTURE; -- behaviour
