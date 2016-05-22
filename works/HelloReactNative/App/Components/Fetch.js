import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  ListView,
} from 'react-native';

class Fetch extends Component {
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
      dataSource: dataSource.cloneWithRows([]),
    };
  }

  componentDidMount() {
    fetch('https://api.github.com/repositories')
      .then((response) => response.json())
      .then((json) => {
        this.setState({
          dataSource: this.state.dataSource.cloneWithRows(json),
        });
      });
  } 

  render() {
    return (
      <ListView dataSource={this.state.dataSource}
        enableEmptySections={true}
        renderRow={this.renderRow}
        renderSeparator={(sectionID, rowID) => <View key={`${sectionID}-${rowID}`} style={styles.separator} />}
      />
    );
  }
  renderRow(data) {
    return (
      <View style={styles.container}>
        <Text style={styles.message}>
          { data.full_name }
        </Text>
      </View>
    );
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

module.exports = Fetch;

