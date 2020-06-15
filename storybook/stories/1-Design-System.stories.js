import React from 'react';
import { linkTo } from '@storybook/addon-links';
import { Welcome } from '@storybook/react/demo';

export default {
  title: 'Design System',
};

export const Palette = () => (
  <div style={{
    display: 'flex', 
    width: '100%', 
    fontFamily: 'helvetica neue'
  }}>
  
  {[
      { name: 'Gray X 11 Gray',   hex: '#bababa' },
      { name: 'Gainsboro',        hex: '#e0e0e0' },
      { name: 'Cultured',         hex: '#f4f4f4' },
      { name: 'Blue Green',       hex: '#4f9bb4' },
      { name: 'Mango Tango',      hex: '#f08e53' },
      { name: 'Atomic Tangerine', hex: '#f19863' },
      { name: 'Jonquil',          hex: '#f9cc01' },
  ].map(color => (
      <div style={{
        flex: '1',
        display: 'table',
        textAlign: 'center', 
        backgroundColor: color.hex, 
        height: '300px', 
        maxWidth: '200px',
        boxSizing: 'border-box',
        paddingBottom: '20px',
      }}>
        <div style={{
          display: 'table-cell',
          verticalAlign: 'bottom',
          fontSize: '.7em',
        }}>
          <div style={{ 
            fontSize: '1.4em', 
            marginBottom: '4px', 
            fontWeight: 500,
            letterSpacing: '2px',
            textTransform: 'uppercase'
          }}>
            {color.hex}
          </div>
          {color.name}     
        </div>
    </div>
  ))}
  </div>
);

Palette.story = {
  name: 'Palette',
};
