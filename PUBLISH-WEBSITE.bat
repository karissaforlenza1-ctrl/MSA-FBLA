@echo off
REM ======================================================
REM  MSA FBLA - Publish Website Updates Automatically
REM  Double-click this file before you start editing.
REM  Every change you save goes live within a few minutes.
REM  Close the black window to stop auto-publishing.
REM ======================================================
title MSA FBLA Auto-Publisher
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0auto-publish.ps1"
pause
