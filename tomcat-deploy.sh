#/bin/sh
echo -e  "Enter your name - \c "
read name
echo -e  "Enter your password - \c "
read password

################ Used to stop the tomcat #################################
function stop_tomcat(){
      sudo service tomcat7 stop
       return ;
}

################ Used to start the tomcat #################################
function start_tomcat(){
      sudo service tomcat7 start
      status = `echo $?`
      if [ $status -ge 0 ]
      then
      echo "Error starting tomcat " 
      exit
       fi


      return ;
}
######################end ################################################


######################### copy the war to webapps ########################
function copy_war(){
       echo "Copying war ------------------"
       sudo cp ~/patch/.war /var/lib/tomcat7/webapps
       ls -ltr  /var/lib/tomcat7/webapps/
       start_tomcat
       echo " ---------------- patch complete --------------------"
}

############################end###########################################


######################### copy the war to webapps ########################
function code_base_patch(){
       echo "Code base patching"
       unrar  x ~/patch/.rar /var/lib/tomcat7/webapps//
       cd /var/lib/tomcat7/webapps//
       ant 
       start_tomcat
       echo " ---------------- patch complete --------------------"
}

############################end###########################################




if  [ $name = "dev" ]
then
     if [ $password = "dev" ]
     then  
  if [ -f "patch_log.log" ]
  then
      echo "Patch started on `date` by - " $name >> patch_log.log
  else
      touch patch_log.log
  fi
  stop_tomcat
  echo -e "Enter mode of deployment - \c"
         read mode
  if [ $mode = "war" ]
           then
              copy_war
    else
       code_base_patch 
              
         fi
      fi
else
     echo "Invalid username/password please try again "
fi
