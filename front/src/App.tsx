import React, { useEffect, useState } from 'react';
import './App.css';
import { createClient } from 'polkadot-api';
import { getWsProvider } from "polkadot-api/ws-provider/web";
import { withPolkadotSdkCompat } from "polkadot-api/polkadot-sdk-compat";
import { dot } from "@polkadot-api/descriptors";
import { chainSpec } from "polkadot-api/chains/polkadot";
import { start } from "polkadot-api/smoldot";
import { getSmProvider } from "polkadot-api/sm-provider";
import { createReferendaSdk } from "@polkadot-api/sdk-governance";




function App() {

  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const smoldot = start()
  const chain = smoldot.addChain({ chainSpec })
  
  const client = createClient(getSmProvider(chain))
  const typedApi = client.getTypedApi(dot)
  
  const referendaSdk = createReferendaSdk(typedApi)
  console.log('chain', referendaSdk);

  return (
    <div className="App">
      <header className="App-header">
        OpenGov Referendum
      </header>
      <div>
      </div>
    </div>
  );
}

export default App;
