- name: Add SSH key
  run: |
    echo "${{ secrets.EC2_SSH_KEY }}" > key.pem
    chmod 600 key.pem

- name: SSH & Deploy App
  run: |
    ssh -o StrictHostKeyChecking=no -i key.pem ec2-user@${{ env.EC2_PUBLIC_IP }} "bash -s" < setup.sh
