# massaverse

Massaverse connects people and Massa blockchain - the decentralized
and scaled blockchain.

## Useful Links

- [Massa: Massa main website](https://massa.net)
- [Testnet: Massa testnet](https://test.massa.net)
- [Massa Github: Massa official github repository](https://github.com/massalabs)
- [Massa API: Massa official api documentation](https://github.com/massalabs/massa/wiki/api)

## Implementation Status
### Functionalities
- [x] core crypto functions
- [x] generation of keys (private key, public key, address)
- [x] network service
- [ ] GUI (Android, iOs, windows, Linux, mac, and web)
### Public API (port:33034)
- [x] get_status
- [ ] get_cliques
- [ ] get_stakers
- [ ] get_operations
- [ ] get_endorsements
- [ ] get_block
- [ ] get_graph_interval
- [ ] get_addresses
- [ ] send_operations
- [ ] get_filtered_sc_output_event
### Private API (port:33034)
- [ ] stop_node
- [ ] node_sign_message
- [ ] add_staking_private_keys
- [ ] remove_staking_addresses
- [ ] get_staking_addresses
- [ ] ban
- [ ] unban