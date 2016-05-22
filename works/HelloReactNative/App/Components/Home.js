import React, { Component } from 'react';
import {
  StyleSheet,
  View,
  Text,
  ListView,
  TouchableWithoutFeedback,
} from 'react-native';

import HelloWorld from './HelloWorld';
import Flexbox from './Flexbox';
import Counter from './Counter';
import Swift from './Swift';
import Storage from './Storage';
import Alert from './Alert';
import Web from './Web';
import Animation from './Animation';
import Fetch from './Fetch';
import Images from './Images';

const DATA = [
  { title: "Hello, World!", component: HelloWorld },
  { title: "Flexbox", component: Flexbox },
  { title: "Counter (Flux)", component: Counter },
  { title: "Swift", component: Swift },
  { title: "AsyncStorage", component: Storage },
  { title: "AlertIOS", component: Alert },
  { title: "WebView", component: Web },
  { title: "Animated", component: Animation },
  { title: "Fetch", component: Fetch },
  { title: "Images", component: Images },
];

class Home extends Component {
  constructor(props) {
    super(props);
    this.state = this.initialState();
    this.renderRow = this.renderRow.bind(this);
  }

  initialState() {
    var dataSource = new ListView.DataSource({
      rowHasChanged: (r1, r2) => r1 !== r2
    });
    return {
      dataSource: dataSource.cloneWithRows(DATA),
    };
  }

  render() {
    return (
      <ListView dataSource={this.state.dataSource}
        renderRow={this.renderRow}
        renderSeparator={(sectionID, rowID) => <View key={`${sectionID}-${rowID}`} style={styles.separator} />}
      />
    );
  }
  renderRow(data) {
    return (
      <TouchableWithoutFeedback onPress={() => this._onPressRow(data)}>
        <View style={styles.container}>
          <Text style={styles.message}>
            { data.title }
          </Text>
        </View>
      </TouchableWithoutFeedback>
    );
  }

  _onPressRow(data) {
    this.props.navigator.push(data);
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  message: {
    fontSize: 20,
    padding: 10,
  },
  separator: {
    height: 1,
    backgroundColor: '#ddd',
  },
});

module.exports = Home;

