// projeto elaborado em C(PIC) utilizando placa de desenvolvimento microgenios
//Leitura do canal A/D AN0, utilizando o canal pwn para controlar um cooler 12V 
//e verificar a velocidade em  RPM atravez de dois censores IR
//usei bibliotecas de LCD 16x2,PWM,Conversor A/D e convorsoes de unidades.


// Variáveis
unsigned char frase[10];   //  texto.
unsigned char porcentagem; //   PWM.
unsigned int leituraAD = 0; //  leitura AD.
unsigned int timer1;    // pulsos do timer 1(rpm).


// CONFIGURAÇÃO DO  LCD.
sbit LCD_RS at RE2_bit;
sbit LCD_EN at RE1_bit;
sbit LCD_D7 at RD7_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D4 at RD4_bit;

void main()

{
   TRISB = 0;                        //  saida.
   TRISD = 0;                        //  saida.
   TRISC.RC0 = 1;                    //  pORTC.RC0 entrada.
   TRISC.RC2 = 0;                    //  pORTC.RC2 saida.
   TRISE = 0;                        //  saida.
   PORTB = 0;                        //  saidas

      // Configuração das interrupções
      //geral
   INTCON.GIEH = 1;
   INTCON.GIEL = 1;
   RCON.IPEN = 1;

   // Timer 0
   INTCON.TMR0IF = 0;
   INTCON2.TMR0IP = 1;
   INTCON.TMR0IE = 1;

   T0CON = 0B10000100;
   TMR0L = 0X7B;
   TMR0H = 0XE1;
   INTCON.TMR0IF = 0;

   // Timer 1
   T1CON = 0B10000011;
   TMR1L = 0;
   TMR1H = 0;
   PIR1.TMR1IF = 0;

   //canais A/D
   ADCON0 = 0b00000001;
   ADCON1 = 0b00001110;
   ADCON2 = 0b10111110;


}