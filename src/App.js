import React from 'react'
import { HashRouter as Router, Switch, Route } from 'react-router-dom'
import { HomePage } from 'pages/'

const App = () => (
  <Router>
    <Switch>
      <Route component={HomePage} />
    </Switch>
  </Router>
)

export default App
