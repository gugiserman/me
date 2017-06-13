import React from 'react'
import PropTypes from 'prop-types'

const SectionIcon = ({ icon, description }) => (
  <div className="fl">
    <img
      className="h1 mr2"
      src={icon}
      alt={description}
    />
  </div>
)

SectionIcon.propTypes = {
  icon: PropTypes.string.isRequired,
  description: PropTypes.string,
}

export default SectionIcon
