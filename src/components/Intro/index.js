import React from 'react'
import { getMyAge } from 'utils/'

const age = getMyAge()

const Intro = () => (
  <section className="pa3 pa4-ns lh-copy">
    <h2 className="db ma0 mb3 f5 f4-ns mb1-ns">
      I'm a minimalist {age}-year-old brazilian developer and passionate about web apps.
    </h2>
    <span className="db mb3 mb1-ns">
      I enjoy delivering good UX.
    </span>
    Did I mention <strong>I vape</strong>?
  </section>
)

export default Intro
