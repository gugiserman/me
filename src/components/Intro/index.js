import React from 'react'
import { getMyAge } from 'utils/'

const age = getMyAge()

const Intro = () => (
  <section className="ph4 pv1 lh-copy">
    <h3 className="db mt0 mb3 mb1-ns">
      I'm a minimalist {age}-year-old brazilian developer and passionate about web apps.
    </h3>
    <span className="db mb3 mb1-ns">
      I enjoy building things that people use online and to provide them a good experience with accessibility and performance.
    </span>
    Did I mention <strong>I vape</strong>?
  </section>
)

export default Intro
