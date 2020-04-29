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

}