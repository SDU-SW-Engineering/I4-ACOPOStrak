<?xml version="1.0" encoding="utf-8"?>
<?AutomationStudio Version=4.7.4.67 SP?>
<SwConfiguration CpuAddress="SL1" xmlns="http://br-automation.co.at/AS/SwConfiguration">
  <TaskClass Name="Cyclic#1" />
  <TaskClass Name="Cyclic#2" />
  <TaskClass Name="Cyclic#3" />
  <TaskClass Name="Cyclic#4">
    <Task Name="Safety" Source="Safety.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="PB1" Source="PB1.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="PP1" Source="PP1.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="PP2" Source="PP2.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="PB2" Source="PB2.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="PP3" Source="PP3.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="PB3" Source="PB3.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="PP4" Source="PP4.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="PP5" Source="PP5.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#5" />
  <TaskClass Name="Cyclic#6" />
  <TaskClass Name="Cyclic#7" />
  <TaskClass Name="Cyclic#8" />
  <Binaries>
    <BinaryObject Name="arsvcreg" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="udbdef" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="TCData" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="arflatprv" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="arcoal" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="mvLoader" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="FWRules" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="mCoWebSc" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="ashwd" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="ashwac" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="User" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="sysconf" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="asfw" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="arconfig" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="Role" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="iomap" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config" Source="" Memory="UserROM" Language="Binary" />
  </Binaries>
  <Libraries>
    <LibraryObject Name="DataObj" Source="Libraries.DataObj.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="AsXml" Source="Libraries.AsXml.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="standard" Source="Libraries.standard.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="runtime" Source="Libraries.runtime.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="FileIO" Source="Libraries.FileIO.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="astime" Source="Libraries.astime.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="mpbase" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="SfDomVis" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="asiodiag" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="asieccon" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="aruser" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="brsystem" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="SfDomDrv" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="sys_lib" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpSfDomMgr" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="asusb" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="astcp" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
  </Libraries>
</SwConfiguration>