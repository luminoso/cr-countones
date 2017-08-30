#include <stdio.h>
#include <stdlib.h>
#include "platform.h"
#include "xparameters.h"
#include "xgpio.h"
#include "microblaze_sleep.h"

//declare an XGpio and XGpio instance
XGpio GPIO_0;
XGpio_Config GPIO_0_conf;

int main() {
        unsigned int input, output;
        unsigned int write_enable;
        unsigned int address;
        unsigned int word;
        unsigned int result;

        GPIO_0_conf.BaseAddress = XPAR_AXI_GPIO_0_BASEADDR;
        GPIO_0_conf.DeviceId = XPAR_GPIO_0_DEVICE_ID;
        GPIO_0_conf.IsDual = XPAR_GPIO_0_IS_DUAL;

        //Initialize the XGpio instance
        XGpio_CfgInitialize(&GPIO_0, &GPIO_0_conf, GPIO_0_conf.BaseAddress);

        init_platform();

        /** GPIO OUTPUT
         *		F         F         F          F   |    F         F          F        F
         *	|_|_|_|_| |_|_|_|_| |_|_|_|_| |_|_|_|_| |_|_|_|_| |_|_|_|_| |_|_|_|_| |_|_|_|_|
         *   |
         *   |                            |-------| |----------------16 BIT---------------|
         *   v                                               word 0xffff
         * write enable                    address 0xF0000
         */

        // array data used to fill the ram
        unsigned int array[] =
                //{ 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 3, 0, 0x0F0 };
        { 0, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF };
        //{ 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF };


        //	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0 };

        // fill ram loop
        for (unsigned int k = 0; k < 16; k++) {

                write_enable = 0x1;
                address = k;
                word = array[k];

                output = 0x00000000;
                output = output | (0x80000000 & (write_enable << 31));
                //xil_printf("w1 = %d\n", output);

                output = output | (0x000F0000 & (address << 16));
                //xil_printf("w2 = %d\n", output);

                output = output | (0x0000FFFF & word);
                //xil_printf("w3 = %d\n", output);

                //xil_printf("===\n");

                XGpio_DiscreteWrite(&GPIO_0, 1, output);

                //xil_printf("k = %d\n", k & 0x1F);
                //MB_Sleep(1);
        }

        output = 0x00000000; // stop writing
        XGpio_DiscreteWrite(&GPIO_0, 1, output);

        xil_printf("finish write to Ram\n");

        /** GPIO INPUT
         *		F         F         F          F   |    F         F          F        F
         *	|_|_|_|_| |_|_|_|_| |_|_|_|_| |_|_|_|_| |_|_|_|_| |_|_|_|_| |_|_|_|_| |_|_|_|_|
         *                                                         |
         *                                                         ||--------9 BITS-------|
         *                                                         v         result 0x1FF
         *                                                  FSM finish 0x200
         */

        while (((input = XGpio_DiscreteRead(&GPIO_0, 2)) & 0x00000200) == 0) {
                xil_printf("Waiting for results... (%d)\n", input);
                //return 0;
        }

        result = input & 0x000001FF;

        xil_printf("result: %d\n", result);

        /** VGA section
         *		F         F         F          F   |    F         F          F        F
         *	|_|_|_|_| |_|_|_|_| |_|_|_|_| |_|_|_|_| |_|_|_|_| |_|_|_|_| |_|_|_|_| |_|_|_|_|
         *   |
         *	 v                  |------8 BIT------|       |------------13 BIT-------------|
         *	write enable             ram data                   ram write address 0x1FF
         */

        unsigned int a;
        unsigned int b;
        unsigned int to_send;

        char sresult[30];
        //memset(sresult, '\0', sizeof(char)*30);
        sprintf(sresult, "%d", result);

        char str[600];
        strcpy(str,"Universidade de Aveiro                                                                              ");
        strcat(str,"                                                                                                    ");
        strcat(str,"Guilherme Cardoso, 45726, gjc@ua.pt                                                                 ");
        strcat(str,"Alvaro Martins,    72447, alvaro.martins@ua.pt                                                      ");
        strcat(str,"                                                                                                    ");
        strcat(str,"Total number of consecutive ones: ");
        strcat(str, sresult);

        char *s1 = str;

        //xil_printf("len: %d\n", strlen(s1));

        b = 0x13;
        b = b + 600;
        for (int k = 0; k < 3600; k++) {

                b++;

                if (k < strlen(s1))
                        a = (int) s1[k];
                else
                        a = (int) ' ';

                to_send = (a << 16) | b;

                XGpio_DiscreteWrite(&GPIO_0, 1, to_send);
        }

        xil_printf("The program terminates\n");
        cleanup_platform();
        //exit 0;
        return 0;
}
