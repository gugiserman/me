import React from 'react'
import { getMyAge } from 'utils/'

const age = getMyAge()

const Intro = () => (
  <section className="h4 pa4">
    I'm a minimalist {age}-year-old front-end developer and passionate about web apps.
  </section>
)

export default Intro
