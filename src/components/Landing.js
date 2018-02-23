import React, { Component } from 'react';
import { View, TextInput, Image, Text, Button, StyleSheet, TouchableOpacity } from 'react-native';
import logo from '../images/logo.png';


const lockIcon = require("../images/lock.png");
const personIcon = require("../images/person.png");

export default class Landing extends Component {

    render() {
        return (
          <View style={styles.wrapper}>
          <Image source={logo} style={{ alignItems:'center', justifyContent:'center', alignSelf:'center', width: 400, height: 200 }}></Image>
            <View style={styles.inputWrap}>
              <View style={styles.iconWrap}>
                <Image
                  source={personIcon}
                  style={styles.icon}
                  resizeMode="contain"
                />
              </View>
              <TextInput
                placeholder="Username"
                style={styles.input}
                underlineColorAndroid="transparent"
              />
            </View>
            <View style={styles.inputWrap}>
              <View style={styles.iconWrap}>
                <Image
                  source={lockIcon}
                  style={styles.icon}
                  resizeMode="contain"
                />
              </View>
              <TextInput
                placeholder="Password"
                secureTextEntry
                style={styles.input}
                underlineColorAndroid="transparent"
              />
            </View>
            <TouchableOpacity activeOpacity={.5}>
              <View style={styles.button}>
                <Text style={styles.buttonText}>Sign In</Text>
              </View>
            </TouchableOpacity>
            <TouchableOpacity activeOpacity={.5}>
              <View>
                <Text style={styles.forgotPasswordText}>Forgot Password?</Text>
              </View>
            </TouchableOpacity>
          </View>
        )
    }
}
const styles = StyleSheet.create({

  wrapper: {
    paddingHorizontal: 25,
  },
  inputWrap: {
    flexDirection: "row",
    marginVertical: 20,
    height: 40,
    width: 300,
    backgroundColor: "transparent",
    alignSelf:'center'
  },
  input: {
    flex: 1,
    paddingHorizontal: 20,
    backgroundColor: '#FFF'
  },
  iconWrap: {
    paddingHorizontal: 17,
    alignItems: "center",
    justifyContent: "center",
    backgroundColor: "#605E5E"
  },
  icon: {
    width: 20,
    height: 20,
  },
  button: {
    backgroundColor: "#605E5E",
    paddingVertical: 15,
    marginVertical: 15,
    alignItems: "center",
    width: 150,
    marginLeft: 120,
    justifyContent: "center",

  },
  buttonText: {
    color: "#FFF",
    fontSize: 18
  },
  forgotPasswordText: {
    color: "#FFF",
    backgroundColor: "transparent",
    textAlign: "center"
  }
});
