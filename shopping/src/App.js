import React, {Component} from 'react';
import logo from './logo.svg';
import './App.css';
import Button from 'material-ui/Button';
import {withStyles} from 'material-ui/styles';
import AppBar from 'material-ui/AppBar';
import Toolbar from 'material-ui/Toolbar';
import Typography from 'material-ui/Typography';

class App extends Component {
  render() {
    return (
      <div className='App'>
        <AppBar position='static' color='primary'>
          <Toolbar>
            <Typography type='subheading' color='inherit'>
              Shopping List
            </Typography>
          </Toolbar>
        </AppBar>
        <Button color='primary'>
          Hello World
        </Button>
      </div>
    );
  }
}

export default App;
