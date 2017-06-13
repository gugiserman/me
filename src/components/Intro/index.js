import React from 'react'
import { getMyAge } from 'utils/'
import { SectionIcon } from 'commons/'
import userSVG from 'assets/icons/user.svg'


const age = getMyAge()

const Intro = () => (
  <section className="pa3 pa4-ns lh-copy">
    <h2 className="db ma0 mb3 f5 f4-ns mb1-ns">
      <SectionIcon icon={userSVG} />
      <span className="v-base">
        I'm a minimalist {age}-year-old brazilian developer and passionate about web apps.
      </span>
    </h2>
    <p className="db mb3 mb1-ns">
      I enjoy delivering great UX.
      <br />
      Did I mention <strong>I vape</strong>?
    </p>
  </section>
)

export default Intro
