# source this file from .profile to add sosh to the PATH

export SOSH=/home/sol/sosh
export PATH="$SOSH"/bin:"$PATH"
source "$SOSH"/sosh.bashrc

(
  echo --[ system solana cli ]----------------------------------------
  solana-install info --local
  solana -V

  echo --[ system summary ]--------------------------------------------
  (
    shopt -s nullglob
    export PS4="==> "
    set -x
    hc
    df -h . /mnt/{nvme*,tmpfs*}
    ded
    free -h
    uptime
  )

  (
    echo --[ sosh ]------------------------------------
    #shellcheck source=/dev/null
    . "$SOSH"/service-env.sh
    echo "$(solana --version): $(readlink -f ~/solana)"

    echo --[ $SOSH_CLUSTER config: $SOSH_CONFIG]-----------
    for keypair in $SOSH_VALIDATOR_IDENTITY $SOSH_VALIDATOR_VOTE_ACCOUNT $SOSH_AUTHORIZED_VOTER; do
      echo "$(basename "$keypair"): $(solana-keygen pubkey "$keypair")"
    done
  )
)
true
