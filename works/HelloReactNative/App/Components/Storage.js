import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  AsyncStorage,
} from 'react-native';

const STORAGE_KEY = "@Storage:key"

class Storage extends Component {
  constructor(props) {
    super(props);
    this.state = this.initialState();
  }

  initialState() {
    return {
      count: 0,
    };
  }

  componentDidMount() {
    AsyncStorage.getItem(STORAGE_KEY).then((value) => {
      if (value == null) {
        value = 0;
      }
      this.setState({ count: value });
      AsyncStorage.setItem(STORAGE_KEY, (parseInt(value) + 1).toString());
    }); 
  }
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.message}>
          { this.state.count }
        </Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  message: {
    fontSize: 20,
  },
});

module.exports = Storage;

