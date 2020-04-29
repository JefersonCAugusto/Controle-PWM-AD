
_main:

;ControleVentiladorRPM.c,26 :: 		void main()
;ControleVentiladorRPM.c,30 :: 		unsigned int leituraAD = 0; //  leitura AD.
	CLRF        main_leituraAD_L0+0 
	CLRF        main_leituraAD_L0+1 
;ControleVentiladorRPM.c,33 :: 		TRISB = 0;                        //  saida.
	CLRF        TRISB+0 
;ControleVentiladorRPM.c,34 :: 		TRISD = 0;                        //  saida.
	CLRF        TRISD+0 
;ControleVentiladorRPM.c,35 :: 		TRISC.RC0 = 1;                    //  pORTC.RC0 entrada.
	BSF         TRISC+0, 0 
;ControleVentiladorRPM.c,36 :: 		TRISC.RC2 = 0;                    //  pORTC.RC2 saida.
	BCF         TRISC+0, 2 
;ControleVentiladorRPM.c,37 :: 		TRISE = 0;                        //  saida.
	CLRF        TRISE+0 
;ControleVentiladorRPM.c,38 :: 		PORTB = 0;                        //  saidas
	CLRF        PORTB+0 
;ControleVentiladorRPM.c,42 :: 		INTCON.GIEH = 1;
	BSF         INTCON+0, 7 
;ControleVentiladorRPM.c,43 :: 		INTCON.GIEL = 1;
	BSF         INTCON+0, 6 
;ControleVentiladorRPM.c,44 :: 		RCON.IPEN = 1;
	BSF         RCON+0, 7 
;ControleVentiladorRPM.c,47 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;ControleVentiladorRPM.c,48 :: 		INTCON2.TMR0IP = 1;
	BSF         INTCON2+0, 2 
;ControleVentiladorRPM.c,49 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;ControleVentiladorRPM.c,51 :: 		T0CON = 0B10000100;
	MOVLW       132
	MOVWF       T0CON+0 
;ControleVentiladorRPM.c,52 :: 		TMR0L = 0X7B;
	MOVLW       123
	MOVWF       TMR0L+0 
;ControleVentiladorRPM.c,53 :: 		TMR0H = 0XE1;
	MOVLW       225
	MOVWF       TMR0H+0 
;ControleVentiladorRPM.c,54 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;ControleVentiladorRPM.c,57 :: 		T1CON = 0B10000011;
	MOVLW       131
	MOVWF       T1CON+0 
;ControleVentiladorRPM.c,58 :: 		TMR1L = 0;
	CLRF        TMR1L+0 
;ControleVentiladorRPM.c,59 :: 		TMR1H = 0;
	CLRF        TMR1H+0 
;ControleVentiladorRPM.c,60 :: 		PIR1.TMR1IF = 0;
	BCF         PIR1+0, 0 
;ControleVentiladorRPM.c,63 :: 		ADCON0 = 0b00000001;
	MOVLW       1
	MOVWF       ADCON0+0 
;ControleVentiladorRPM.c,64 :: 		ADCON1 = 0b00001110;
	MOVLW       14
	MOVWF       ADCON1+0 
;ControleVentiladorRPM.c,65 :: 		ADCON2 = 0b10111110;
	MOVLW       190
	MOVWF       ADCON2+0 
;ControleVentiladorRPM.c,67 :: 		Lcd_Init();                               // Inicializa LCD.
	CALL        _Lcd_Init+0, 0
;ControleVentiladorRPM.c,69 :: 		Lcd_Cmd(_LCD_CLEAR);                      // apaga display.
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;ControleVentiladorRPM.c,70 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);                 // desliga cursor.
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;ControleVentiladorRPM.c,71 :: 		Lcd_Out(1, 1, "Duty Cycle: ");            // imprime linha 1 coluna1
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_ControleVentiladorRPM+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_ControleVentiladorRPM+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;ControleVentiladorRPM.c,73 :: 		PWM1_Init(5000);                  // 1nicializa módulo PWM 5Khz
	BSF         T2CON+0, 0, 0
	BCF         T2CON+0, 1, 0
	MOVLW       99
	MOVWF       PR2+0, 0
	CALL        _PWM1_Init+0, 0
;ControleVentiladorRPM.c,74 :: 		PWM1_Set_Duty(255);               //duty-cycle do PWM em 100%.   1 byte
	MOVLW       255
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;ControleVentiladorRPM.c,75 :: 		PWM1_Start();                     // inicia PWM.
	CALL        _PWM1_Start+0, 0
;ControleVentiladorRPM.c,77 :: 		while(1){
L_main0:
;ControleVentiladorRPM.c,79 :: 		leituraAD= ADC_Read(0);          // lê Canal AD em uso
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       main_leituraAD_L0+0 
	MOVF        R1, 0 
	MOVWF       main_leituraAD_L0+1 
;ControleVentiladorRPM.c,80 :: 		LeituraAD=(leituraAD*0.24);     // converte  duty cycle 255/1023
	CALL        _Word2Double+0, 0
	MOVLW       143
	MOVWF       R4 
	MOVLW       194
	MOVWF       R5 
	MOVLW       117
	MOVWF       R6 
	MOVLW       124
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       main_leituraAD_L0+0 
	MOVF        R1, 0 
	MOVWF       main_leituraAD_L0+1 
;ControleVentiladorRPM.c,81 :: 		PWM1_Set_Duty(leituraAD);        // envia o valor p/ PWM
	MOVF        R0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;ControleVentiladorRPM.c,82 :: 		leituraAD=(leituraAD*0.41);     // converte  duty cycle em %
	MOVF        main_leituraAD_L0+0, 0 
	MOVWF       R0 
	MOVF        main_leituraAD_L0+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVLW       133
	MOVWF       R4 
	MOVLW       235
	MOVWF       R5 
	MOVLW       81
	MOVWF       R6 
	MOVLW       125
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       main_leituraAD_L0+0 
	MOVF        R1, 0 
	MOVWF       main_leituraAD_L0+1 
;ControleVentiladorRPM.c,83 :: 		WordToStr(leituraAD, frase);   // converte no A/D em string
	MOVF        R0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       main_frase_L0+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(main_frase_L0+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;ControleVentiladorRPM.c,84 :: 		Lcd_Out(1,11,frase);            // imprime Duty Cycle.
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_frase_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_frase_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;ControleVentiladorRPM.c,87 :: 		WordToStr(timer1, frase);  // converte o valor para string
	MOVF        main_timer1_L0+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        main_timer1_L0+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       main_frase_L0+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(main_frase_L0+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;ControleVentiladorRPM.c,88 :: 		Lcd_Out(2,1,frase);             // imprime no RPM.
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_frase_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_frase_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;ControleVentiladorRPM.c,89 :: 		Lcd_Out_CP(" RPM");               // string "RPM".
	MOVLW       ?lstr2_ControleVentiladorRPM+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr2_ControleVentiladorRPM+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;ControleVentiladorRPM.c,91 :: 		}
	GOTO        L_main0
;ControleVentiladorRPM.c,92 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
