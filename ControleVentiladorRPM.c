
// projeto elaborado em C(PIC) utilizando placa de desenvolvimento microgenios
//Leitura do canal A/D AN0, utilizando o canal pwn para controlar um cooler 12V
//e verificar a velocidade em  RPM atravez de dois censores IR
//usei bibliotecas de LCD 16x2,PWM,Conversor A/D e convorsoes de unidades.


// Variáveis


// CONFIGURAÇÃO DO  LCD.
sbit LCD_RS at RE2_bit;
sbit LCD_EN at RE1_bit;
sbit LCD_D7 at RD7_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_RS_Direction at TRISE2_bit;
sbit LCD_EN_Direction at TRISE1_bit;
sbit LCD_D7_Direction at TRISD7_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D4_Direction at TRISD4_bit;


void main()
{
unsigned char frase[10];   //  texto.
unsigned char porcentagem; //   PWM.
unsigned int leituraAD = 0; //  leitura AD.
unsigned int timer1;    // pulsos do timer 1(rpm).

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

    Lcd_Init();                               // Inicializa LCD.

   Lcd_Cmd(_LCD_CLEAR);                      // apaga display.
   Lcd_Cmd(_LCD_CURSOR_OFF);                 // desliga cursor.
   Lcd_Out(1, 1, "Duty Cycle: ");            // imprime linha 1 coluna1

   PWM1_Init(5000);                  // 1nicializa módulo PWM 5Khz
   PWM1_Set_Duty(255);               //duty-cycle do PWM em 100%.   1 byte
   PWM1_Start();                     // inicia PWM.

   while(1){

      leituraAD= ADC_Read(0);          // lê Canal AD em uso
      LeituraAD=(leituraAD*0.24);     // converte  duty cycle 255/1023
      PWM1_Set_Duty(leituraAD);        // envia o valor p/ PWM
      leituraAD=(leituraAD*0.41);     // converte  duty cycle em %
      WordToStr(leituraAD, frase);   // converte no A/D em string
      Lcd_Out(1,11,frase);            // imprime Duty Cycle.


      WordToStr(timer1, frase);  // converte o valor para string
      Lcd_Out(2,1,frase);             // imprime no RPM.
      Lcd_Out_CP(" RPM");               // string "RPM".
      Delay_10us;                     //espera para aparecer no display
   }
}