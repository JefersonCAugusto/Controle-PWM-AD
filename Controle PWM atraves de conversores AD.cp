#line 1 "C:/Users/Guto/Desktop/projeto/Controle PWM atraves de conversores AD.c"










sbit LCD_RS at RE2_bit;
sbit LCD_EN at RE1_bit;
sbit LCD_D7 at RD7_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D4 at RD4_bit;

void main()
{
unsigned char frase[10];
unsigned char porcentagem;
unsigned int leituraAD = 0;
unsigned int timer1;

 TRISB = 0;
 TRISD = 0;
 TRISC.RC0 = 1;
 TRISC.RC2 = 0;
 TRISE = 0;
 PORTB = 0;



 INTCON.GIEH = 1;
 INTCON.GIEL = 1;
 RCON.IPEN = 1;


 INTCON.TMR0IF = 0;
 INTCON2.TMR0IP = 1;
 INTCON.TMR0IE = 1;

 T0CON = 0B10000100;
 TMR0L = 0X7B;
 TMR0H = 0XE1;
 INTCON.TMR0IF = 0;


 T1CON = 0B10000011;
 TMR1L = 0;
 TMR1H = 0;
 PIR1.TMR1IF = 0;


 ADCON0 = 0b00000001;
 ADCON1 = 0b00001110;
 ADCON2 = 0b10111110;

 Lcd_Init();

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1, 1, "Duty Cycle: ");

 PWM1_Init(5000);
 PWM1_Set_Duty(255);
 PWM1_Start();

 while(1){

 leituraAD= ADC_Read(0);
 LeituraAD=(leituraAD*0.24);
 PWM1_Set_Duty(leituraAD);
 leituraAD=(leituraAD*0.41);
 WordToStr(leituraAD, frase);
 Lcd_Out(1,11,frase);


 WordToStr(timer1, frase);
 Lcd_Out(2,1,frase);
 Lcd_Out_CP(" RPM");
 Delay_10us;
 }
}
