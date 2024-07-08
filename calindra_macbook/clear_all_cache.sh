#!/bin/zsh

exit 

# Android
rm -rf ~/.android/cache/*
rm -rf ~/.gradle/*
rm -rf ~/.m2/repository/*

# iOS
rm -rf ~/.bundle/*
rm -rf ~/.cocoapods/*
rm -rf ~/.lldb/*
rm -rf ~/.swiftpm/*
rm -rf ~/Library/Developer/Xcode/DerivedData/*

# JavaScript (volta, npm)
rm -rf ~/.volta/cache/*
rm -rf ~/.volta/log/*
rm -rf ~/.volta/tmp/*
rm -rf ~/.npm/*

