#!/bin/bash
export HISTIGNORE='*sudo -S';
pass="xxxx";
temp="$(date "+%d_%m_%Y")";
save_path="skrypciki/upgrade/upgrade_$temp.log" ;
date >> $save_path;

echo "BEGIN OF UPDATE" >>  $save_path;
echo $pass | sudo -S -k apt-get update |& tee -a >>  $save_path;
echo "END OF UPDATE" >>  $save_path;
echo "BEGIN OF UPGRADING" >>  $save_path;
echo $pass | sudo -S -k apt-get upgrade --assume-yes |& tee -a >>  $save_path;
echo "END OF UPGRADING" >>  $save_path;
echo "BEGIN OF  AUTOREMOVE" >>  $save_path;
echo $pass | sudo -S -k apt-get autoremove --assume-yes |& tee -a >>  $save_path;
echo "END OF AUTOREMOVE" >>  $save_path;
echo "BEGIN OF AUTOCLEAN" >>  $save_path;
echo $pass | sudo -S -k apt-get autoclean --assume-yes |& tee -a >>  $save_path;
echo "END OF AUTOCLEAN" >>  $save_path;

echo "END OF SCRIPT" >>  $save_path;

echo "REBOOT AT $(date)" >>  $save_path;

echo $pass | sudo -S -k reboot;
