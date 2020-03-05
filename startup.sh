#!/bin/bash
service nginx status
service nginx restart
ls
gunicorn3 app:app
