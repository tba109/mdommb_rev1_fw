import sys
import os

def main(): 
    fout = open('./hdl/rev_num/rev_num.v','w')
    if sys.argv[1]=='1': 
        print('Setuping up for rev1')
        os.system('cp ./constrs/io_rev1.xdc ./constrs/io.xdc')
        fout.write('`define MDOMREV1\n')
    else:
        print('Setting up for rev2')
        os.system('cp ./constrs/io_rev2.xdc ./constrs/io.xdc')
        fout.write('`define MDOMREV2\n')
    fout.close()

if __name__ == "__main__":
    main()
