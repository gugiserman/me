import React from 'react'
import PropTypes from 'prop-types'

import {
  Header,
  Intro,
  CurrentWork,
  Contact,
} from 'components/'

const HomePage = () => (
  <div>
    <Header />
    <Intro />
    <CurrentWork />
    <Contact />
  </div>
)

export default HomePage
